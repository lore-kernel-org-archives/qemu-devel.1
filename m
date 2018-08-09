Received: from eggs.gnu.org ([2001:4830:134:3::10]:53330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnkud-0007vp-OQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnkuc-0002fT-Ss
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:23:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnkuc-0002f9-NL
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:23:34 -0400
References: <1533796396-20483-1-git-send-email-whois.zihan.yang@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8474720-729d-a44c-a329-9adbff6d9027@redhat.com>
Date: Thu, 9 Aug 2018 08:23:33 -0500
MIME-Version: 1.0
In-Reply-To: <1533796396-20483-1-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 1/6] pci_expander_bridge: add type
 TYPE_PXB_PCIE_HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 08/09/2018 01:33 AM, Zihan Yang wrote:
> The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by default,
> change it to a new type TYPE_PXB_PCIE_HOST to better utilize ECAM of PCIe

meta-comment:

Your messages came through unthreaded (seven separate threads), rather 
than properly marked 'References:' and 'In-reply-to:' to the 0/6 cover 
letter <1533796115-15837-1-git-send-email-whois.zihan.yang@gmail.com>, 
which makes it a bit harder to keep track of the conversation when 
viewing mails sorted by threads with most recent activity.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
