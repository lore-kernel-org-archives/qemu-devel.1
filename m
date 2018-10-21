Received: from eggs.gnu.org ([2001:4830:134:3::10]:60371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJQv-0001hz-Mj
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJLx-0001U8-Eo
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:25:35 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:55566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gEJLq-0001TC-Lk
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:25:30 -0400
Date: Sun, 21 Oct 2018 21:25:21 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181021192521.mazhhkeunyktoohf@function>
References: <20180914072616.17771-1-famz@redhat.com>
	<20180914072616.17771-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914072616.17771-3-famz@redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Hello,

Fam Zheng, le ven. 14 sept. 2018 15:26:16 +0800, a ecrit:
> This new usernet option can be used to add data for option 66 (tftp
> server name) in the BOOTP reply, which is useful in PXE based automatic
> OS install such as OpenBSD.

Applied to my tree, thanks!

Samuel
