Received: from eggs.gnu.org ([2001:4830:134:3::10]:35042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dA9bb-0006fT-DK
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dA9bY-0004kc-CQ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dA9bY-0004im-7F
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:35:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45CDA369C3
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:35:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-5-marcandre.lureau@redhat.com>
	<874lwqjzjl.fsf@dusky.pond.sub.org>
	<20170512090335.6b20c3ec@redhat.com>
Date: Mon, 15 May 2017 08:35:32 +0200
In-Reply-To: <20170512090335.6b20c3ec@redhat.com> (Luiz Capitulino's message
	of "Fri, 12 May 2017 09:03:35 -0400")
Message-ID: <87bmqu4ogb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Luiz Capitulino <lcapitulino@redhat.com> writes:

> On Fri, 12 May 2017 09:37:50 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Luiz, there's a lone question for you further down.  Search for your
>> name.
>
> I could not a question, can you paste it here?

Uh, I actually spun it out into its own message, so you don't have to
wade through this one, then forgot to update this one.  I award myself
one point out of ten for trying.
