Received: from eggs.gnu.org ([2001:4830:134:3::10]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dLopT-0002m3-SZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dLopP-0006Lb-1z
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:50:15 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:46069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dLopO-0006KD-MD
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:50:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170614153557.3319-8-stefanha@redhat.com>
References: <20170614153557.3319-1-stefanha@redhat.com>
	<20170614153557.3319-8-stefanha@redhat.com>
Date: Fri, 16 Jun 2017 12:50:07 +0200
Message-ID: <w51a858tdeo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 7/9] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Wed 14 Jun 2017 05:35:55 PM CEST, Stefan Hajnoczi wrote:
> The measure subcommand calculates the size required by a new image file.
> This can be used by users or management tools that need to allocate
> space on an LVM volume, SAN LUN, etc before creating or converting an
> image file.
>
> Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
