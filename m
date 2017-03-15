Received: from eggs.gnu.org ([2001:4830:134:3::10]:36787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8du-0000yP-Oo
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8dp-0006Tf-Rl
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:07:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8dp-0006S1-MK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:07:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<CAJ+F1CK1=b5sbTiu06cQyvV_ROaONPv5DUF366xRnmmi13=gHA@mail.gmail.com>
Date: Wed, 15 Mar 2017 14:06:58 +0100
In-Reply-To: <CAJ+F1CK1=b5sbTiu06cQyvV_ROaONPv5DUF366xRnmmi13=gHA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 14 Mar 2017
	13:24:26 +0000")
Message-ID: <87tw6uit8t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/47] qapi: Put type information
 back into QMP documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Mar 13, 2017 at 10:23 AM Markus Armbruster <armbru@redhat.com>
> wrote:
>
>> I'm proposing this is 2.9 because it fixes a documentation regression.
>> It affects only documentation; generated C code is unchanged except
>> for the removal of trailing space in PATCH 46.
[...]
> Except the few comments and questions I left, the series looks good to me.
> I don't think we need to rush it in the 2.9 release though, but I will let
> the maintainers decide how to deal with the planning and rules.

Letting documentation quality regress in 2.9 wouldn't be the end of the
world, but this series is as safe as they get, despite its size.

Thanks for your review!
