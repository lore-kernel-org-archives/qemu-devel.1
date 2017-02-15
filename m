Received: from eggs.gnu.org ([2001:4830:134:3::10]:57334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwbz-0007Pd-SZ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwbv-00052P-Uv
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:59 -0500
References: <1486576658-29719-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <7bc689db-8f76-d9ad-ffd3-688d2f964431@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:14:53 +0300
MIME-Version: 1.0
In-Reply-To: <1486576658-29719-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/core/register: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

08.02.2017 20:57, Thomas Huth wrote:
> The "qemu,register" device needs to be wired up in source code, there
> is no way the user can make any real use of this device with the
> "-device" parameter or the "device_add" monitor command yet.

Applied both v3 patches to -trivial, thank you!

/mjt
