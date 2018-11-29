Received: from eggs.gnu.org ([2001:4830:134:3::10]:37247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSMey-0001M3-6k
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSMeu-0004vc-7Q
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:47:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSMet-0004vC-Vy
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:47:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F16930A3AC4
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 13:47:11 +0000 (UTC)
References: <20181129104658.26585-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <569735e2-9aa2-1f10-412d-c1850fb26660@redhat.com>
Date: Thu, 29 Nov 2018 14:47:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181129104658.26585-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 2018-11-29 11:46, Daniel P. Berrang=C3=A9 wrote:
> Add a README file that tells people this is a jekyll based static
> website, and shows people how to run jekyll for testing purposes.
>=20
> Tested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitignore  |  2 ++
>  README      | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  _config.yml |  2 ++
>  3 files changed, 59 insertions(+)
>  create mode 100644 README

Thanks, applied (with the typo fixed).

 Thomas
