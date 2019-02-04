Received: from eggs.gnu.org ([209.51.188.92]:57312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqhHu-0003RV-N2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqhHs-0007a4-RX
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:40:02 -0500
Date: Mon, 4 Feb 2019 17:39:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204173916.77944f02.cohuck@redhat.com>
In-Reply-To: <351ec816-8414-2e24-050c-08043cc49cc6@redhat.com>
References: <154929778819.29184.14263501563008780216@ebba9967afc0>
	<351ec816-8414-2e24-050c-08043cc49cc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/tcg: Don't model FP registers as
 globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, qemu-s390x@nongnu.org, thuth@redhat.com, rth@twiddle.net

On Mon, 4 Feb 2019 17:32:50 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.02.19 17:29, no-reply@patchew.org wrote:

> > Configure options:
> > --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/tmp/qemu-test/install --python=/usr/bin/python3 --cross-prefix=x86_64-w64-mingw32- --enable-trace-backends=simple --enable-gnutls --enable-nettle --enable-curl --enable-vnc --enable-bzip2 --enable-guest-agent --with-sdlabi=2.0
> > ERROR: unknown option --with-sdlabi=2.0

> Looks like Patchew is experiencing technical problems :)
> 

That's the known sdlabi problem, nothing to do with your patch :)
