Received: from eggs.gnu.org ([2001:4830:134:3::10]:48547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cUyeZ-00053W-6Z
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 11:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cUyeV-0004qa-C5
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 11:36:35 -0500
References: <20170115203014.GA12068@var.home>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <cc393a67-3c26-6155-afa7-d53809eb73ab@msgid.tls.msk.ru>
Date: Sat, 21 Jan 2017 19:36:18 +0300
MIME-Version: 1.0
In-Reply-To: <20170115203014.GA12068@var.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Drop duplicate display option documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

15.01.2017 23:30, Samuel Thibault wrote:
> The curses and none possibilities are already documented on a separate line,
> so documenting it on the sdl line was both unneeded and confusing.

Applied to -trivial, thanks!

/mjt
