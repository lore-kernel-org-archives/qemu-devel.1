Received: from eggs.gnu.org ([209.51.188.92]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwWB-0005de-Fh
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwW2-0004fy-2g
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:55:40 -0500
Date: Tue, 5 Feb 2019 09:55:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205085525.jc6zj6p5jbcngcmk@sirius.home.kraxel.org>
References: <1549282241-23535-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549282241-23535-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ui/sdl_keysym: Remove obsolete SDL1.2
 related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>

On Mon, Feb 04, 2019 at 01:10:41PM +0100, Thomas Huth wrote:
> sdl_keysym.h has only been included by sdl.c which has recently been
> removed recently with this commit:
> 
>   0015ca5cbabe0b31d31610ddfaafd90a9e5911a4
>   ("ui: remove support for SDL1.2 in favour of SDL2")
> 
> So we can drop this header file now completely, too.

Added to UI queue.

thanks,
  Gerd
