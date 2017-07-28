Received: from eggs.gnu.org ([2001:4830:134:3::10]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db0SC-00036b-7T
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db0SA-0007V8-7n
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:17:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db0SA-0007Ue-1G
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:16:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 208EE40805
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 08:16:57 +0000 (UTC)
Date: Fri, 28 Jul 2017 09:16:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728081651.GD31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728063432.27578-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728063432.27578-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: add pause key to linux_to_qcode
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

On Fri, Jul 28, 2017 at 08:34:32AM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/input-keymap.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
