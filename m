Received: from eggs.gnu.org ([2001:4830:134:3::10]:43985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit@kernel.org>) id 1dWpUL-0006WG-6v
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit@kernel.org>) id 1dWpUK-00057f-9S
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:45:57 -0400
Date: Sun, 16 Jul 2017 21:45:50 +0200
From: Amit Shah <amit@kernel.org>
Message-ID: <20170716194550.GB2964@grmbl.mre>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-18-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170713163219.9024-18-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/29] virtio-serial: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, peter.maydell@linaro.org, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On (Thu) 13 Jul 2017 [18:32:07], Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Amit Shah <amit@kernel.org>

		Amit
-- 
http://log.amitshah.net/
