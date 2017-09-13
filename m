Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dsBbu-0001zA-UC
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dsBbr-0000LJ-LO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:38:02 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:20029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1dsBbr-0000Jr-Cy
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:37:59 -0400
Date: Wed, 13 Sep 2017 10:56:25 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170913145625.GA10319@char.us.oracle.com>
References: <20170901105023.11108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901105023.11108-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pixman: drop submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Sep 01, 2017 at 12:50:23PM +0200, Gerd Hoffmann wrote:
> Drop pixman submodule and support for the "internal" pixman build.
> pixman should be reasonable well established meanwhile that we don't
> need the fallback submodule any more.  While being at it also drop
> some #ifdefs for pixman versions olter than what we require in

s/olter/older/
