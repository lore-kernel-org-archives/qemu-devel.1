Received: from eggs.gnu.org ([2001:4830:134:3::10]:37021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dc7A0-00055Q-7p
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dc79w-0003or-92
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:38:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dc79w-0003m1-31
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:38:44 -0400
Date: Mon, 31 Jul 2017 10:38:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170731093836.GD766@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <BAB68128-33C3-4160-87D1-116ABE087536@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BAB68128-33C3-4160-87D1-116ABE087536@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Add more function keys to cocoa.m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Sun, Jul 30, 2017 at 04:29:47PM -0400, Programmingkid wrote:
> Enable the Cocoa front-end to be able to use function keys F16 to F20.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
