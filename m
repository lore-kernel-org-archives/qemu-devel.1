Received: from eggs.gnu.org ([2001:4830:134:3::10]:42779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drpg8-0002kV-L8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drpg3-0005lD-OC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:12:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1drpg3-0005ks-IT
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:12:51 -0400
Date: Tue, 12 Sep 2017 15:12:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170912181247.GE7570@localhost.localdomain>
References: <cover.1505158760.git.alistair.francis@xilinx.com>
	<1d6ef2ccd9667878ed5820fcf17eef35957ea5d8.1505158760.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6ef2ccd9667878ed5820fcf17eef35957ea5d8.1505158760.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/8] hw/i386: Improve some of the
 warning messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com

On Mon, Sep 11, 2017 at 12:52:43PM -0700, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
> V4:
>  - Fixup pc_q35.c message
> V3:
>  - Improve the messages
> 

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
