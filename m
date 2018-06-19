Received: from eggs.gnu.org ([2001:4830:134:3::10]:37874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVAAt-00069d-Cv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVAAp-0003CJ-F4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:31:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVAAp-0003CD-AW
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFD0540201BE
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 06:31:26 +0000 (UTC)
Date: Tue, 19 Jun 2018 08:31:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180619063125.jq5z7b7u66akfezk@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-15-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180618161729.334-15-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/26] Add vhost-user-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1206,6 +1206,7 @@ L: qemu-s390x@nongnu.org
>  virtio-input
>  M: Gerd Hoffmann <kraxel@redhat.com>

R: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

(or a separate vhost-input-user entry)

>  S: Maintained
> +F: hw/input/vhost-user-input.c

F: contrib/vhost-user-input/*

>  F: hw/input/virtio-input*.c
>  F: include/hw/virtio/virtio-input.h

cheers,
  Gerd
