Received: from eggs.gnu.org ([2001:4830:134:3::10]:44567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ch6vz-0007bT-FV
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ch6vy-0006CG-Oj
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:52:43 -0500
Date: Thu, 23 Feb 2017 22:52:36 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170224035236.GB2613@localhost.localdomain>
References: <20170221065003.26103-1-jazeltq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170221065003.26103-1-jazeltq@gmail.com>
Subject: Re: [Qemu-devel] [RFC v6] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jazeltq@gmail.com
Cc: jdurgin@redhat.com, dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, tianqing <tianqing@unitedstack.com>

On Tue, Feb 21, 2017 at 02:50:03PM +0800, jazeltq@gmail.com wrote:
> From: tianqing <tianqing@unitedstack.com>
> 
> Rbd can do readv and writev directly, so wo do not need to transform
> iov to buf or vice versa any more.
> 
> Signed-off-by: tianqing <tianqing@unitedstack.com>
> ---


This is marked as an RFC still - is this a series you would like to see in
2.9?
