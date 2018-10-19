Received: from eggs.gnu.org ([2001:4830:134:3::10]:57784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDUbo-0008AL-2M
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDUbl-00066r-GU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gDUbl-00066I-Ag
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEE0DC04AC54
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 13:14:28 +0000 (UTC)
References: <20181019122613.28663-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c48219f3-4af6-22de-15b3-a1263aa46096@redhat.com>
Date: Fri, 19 Oct 2018 08:14:18 -0500
MIME-Version: 1.0
In-Reply-To: <20181019122613.28663-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: remove or downgrade myself to
 reviewer from some subsystems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 10/19/18 7:26 AM, Paolo Bonzini wrote:
> Other people are doing a much better work than myself at handling some
> subsystems.  For those files it is better if I downgrade myself to
> reviewer or recognize that I am not actually doing any work there.
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   MAINTAINERS | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

NBD portion:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
