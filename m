Received: from eggs.gnu.org ([2001:4830:134:3::10]:53382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkXHk-0000rB-Vg
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkXHf-00035i-57
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:09:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dkXHe-00035E-Vj
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:09:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 109994A6F4
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 15:09:30 +0000 (UTC)
Message-ID: <1503500950.16071.33.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Aug 2017 17:09:10 +0200
In-Reply-To: <87d17ur7y1.fsf@dusky.pond.sub.org>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-17-marcandre.lureau@redhat.com>
	<87d17ur7y1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/26] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

  Hi,

> Observation: we got >250 lines of VNC stuff in qapi-
> schema.json.=C2=A0=C2=A0Moving
> them into qapi/vnc.json would permit proper MAINTAINERS
> coverage.=C2=A0=C2=A0Gerd,
> what do you think?

Yes, looks useful to me.

cheers,
  Gerd
