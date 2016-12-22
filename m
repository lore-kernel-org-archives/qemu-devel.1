Received: from eggs.gnu.org ([2001:4830:134:3::10]:38019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cJyru-000776-Ad
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 03:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cJyrr-0007qE-85
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 03:36:54 -0500
Message-ID: <1482395799.3732.45.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 22 Dec 2016 09:36:39 +0100
In-Reply-To: <20161221224326.GB14282@umbus.fritz.box>
References: <20161215061128.30792-1-david@gibson.dropbear.id.au>
	<1482160529.3732.2.camel@redhat.com>
	<20161219234717.GG23176@umbus.fritz.box>
	<1482225561.3732.12.camel@redhat.com>
	<20161221045245.GE13024@umbus.fritz.box>
	<1482309497.3732.30.camel@redhat.com>
	<20161221224326.GB14282@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 for-2.9 0/6] HPT resizing for
 pseries guests (qemu part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 2016-12-22 at 09:43 +1100, David Gibson wrote:
> > The name makes sense, we just need to document the host
> > kernel requirement properly. The error message should of
> > course mention it as well.
> 
> The error message is currently
> 
> "Hash page table resizing not available with this KVM version"
> 
> Does that cover it?

Sounds good to me.

-- 
Andrea Bolognani / Red Hat / Virtualization
