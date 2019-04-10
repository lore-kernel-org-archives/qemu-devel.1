Received: from eggs.gnu.org ([209.51.188.92]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hE7gR-0003hl-8f
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hE7gQ-0002Wu-E2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:30:11 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hE7gQ-0002RR-55
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:30:10 -0400
Received: by mail-wr1-f53.google.com with SMTP id h4so1595813wre.7
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 00:30:09 -0700 (PDT)
Date: Wed, 10 Apr 2019 09:30:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190410073005.orqlxvqdp7ebwbas@steredhat>
References: <20190409154435.28807-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190409154435.28807-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: replace min-glib with fedora
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Apr 09, 2019 at 05:44:35PM +0200, Marc-André Lureau wrote:
> min-glib.docker was removed in commit
> e7b3af81597db1a6b55f2c15d030d703c6b2c6ac ("glib: bump min required
> glib library version to 2.40").
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/testing.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
