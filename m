Received: from eggs.gnu.org ([2001:4830:134:3::10]:47848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0o6-0003V6-Ba
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0o2-0005CK-9f
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJ0o2-0005C8-42
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3472BCD25
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 17:01:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-16-marcandre.lureau@redhat.com>
	<87mv9i4eia.fsf@dusky.pond.sub.org>
Date: Thu, 08 Jun 2017 19:01:04 +0200
In-Reply-To: <87mv9i4eia.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 08 Jun 2017 18:42:53 +0200")
Message-ID: <8760g62z3j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/43] qdev: rename
 DEFINE_PROP_DEFAULT() to DEFINE_PROP_SIGNED()
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

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Prepare for the next patch's DEFINE_PROP_UNSIGNED().
>
> Suggest "To prepare for the", or "In preparation of the", or "The rename
> prepares for the".

Also "the patch after next's".

> While there, tidy up case in the title to "qdev: Rename ..."
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
