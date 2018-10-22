Received: from eggs.gnu.org ([2001:4830:134:3::10]:47266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gEZq2-0003Ts-Ec
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gEZpx-0002Am-Et
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gEZpx-00029b-74
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:01:37 -0400
Date: Mon, 22 Oct 2018 21:01:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181022130131.GC11958@magic>
References: <20180914072616.17771-1-famz@redhat.com>
	<20180914072616.17771-3-famz@redhat.com>
	<20181021192521.mazhhkeunyktoohf@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021192521.mazhhkeunyktoohf@function>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] slirp: Implement RFC2132 TFTP
 server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org

On Sun, 10/21 21:25, Samuel Thibault wrote:
> Hello,
> 
> Fam Zheng, le ven. 14 sept. 2018 15:26:16 +0800, a ecrit:
> > This new usernet option can be used to add data for option 66 (tftp
> > server name) in the BOOTP reply, which is useful in PXE based automatic
> > OS install such as OpenBSD.
> 
> Applied to my tree, thanks!
> 

Thank you Samuel for taking care of this! Now I can merge my OpenBSD test
patches.

Fam
