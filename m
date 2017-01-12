Received: from eggs.gnu.org ([2001:4830:134:3::10]:53121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdDa-0002UP-Ng
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdDY-000799-HQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:06:54 -0500
References: <1484132542-22520-1-git-send-email-kraxel@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <196dd8f1-4a2a-e085-ad3a-7db97a10668f@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 14:06:51 +0300
MIME-Version: 1.0
In-Reply-To: <1484132542-22520-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docs: sync pci-ids.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

11.01.2017 14:02, Gerd Hoffmann wrote:
> Three commits allocated pci ids in include/hw/pci/pci.h
> without also updating docs/specs/pci-ids.txt:
> 
>   bf439db pci: Allocate PCIe host bridge PCI ID
>   40d14be hw/pci: introduce PCI Expander Bridge (PXB)
>   02b0743 hw/pxb: introduce pxb-pcie expander for PCIe machines
> 
> This patch updates pci-ids.txt accordingly.

Applied to -trivial, thank you!

/mjt
