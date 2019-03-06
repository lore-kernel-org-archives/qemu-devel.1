Received: from eggs.gnu.org ([209.51.188.92]:59936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h1SY0-0003Pc-KP
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h1SXu-0000yW-Rw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:09:08 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1h1SXu-0000te-0e
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:09:02 -0500
Received: by mail-wr1-f53.google.com with SMTP id o17so12489909wrw.3
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 01:09:00 -0800 (PST)
Date: Wed, 6 Mar 2019 10:08:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190306090856.xpazo3cexcnworxq@steredhat.homenet.telecomitalia.it>
References: <20190305225135.7060-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305225135.7060-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user-test: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>

On Tue, Mar 05, 2019 at 11:51:35PM +0100, Marc-André Lureau wrote:
> Spotted by ASAN.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/vhost-user-test.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
