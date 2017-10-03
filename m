Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzTna-0007Pb-2w
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzTnV-0008BZ-67
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzTnU-0008As-W0
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:28:09 -0400
Date: Tue, 3 Oct 2017 17:28:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003202803.GB4760@localhost.localdomain>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/5] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

On Tue, Oct 03, 2017 at 01:05:11PM -0700, Alistair Francis wrote:
> List all possible valid CPU options.
> 
> Although the board only ever has a Cortex-M3 we mark the Cortex-M4 as
> supported because the Netduino2 Plus supports the Cortex-M4 and the
> Netduino2 Plus is similar to the Netduino2.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
