Received: from eggs.gnu.org ([2001:4830:134:3::10]:42943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSKUg-00018s-Lu
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSKMo-0004H8-J7
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:20:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSKMo-0004Gm-BP
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:20:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0ABD3091791
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:20:21 +0000 (UTC)
References: <20181129110334.27721-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e7e922c5-e8f3-a06d-a62d-a1eb27f31dcb@redhat.com>
Date: Thu, 29 Nov 2018 12:20:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181129110334.27721-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v3] download: document version
 numbering scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 2018-11-29 12:03, Daniel P. Berrang=C3=A9 wrote:
> The new version numbering scheme was mentioned in the blog post
> announcing 3.0 previously, but this will fall out of view over
> time. It is thus preferrable to mention this on the download page
> too.
>=20
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  download.html | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Thanks, applied now.

 Thomas
