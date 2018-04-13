Received: from eggs.gnu.org ([2001:4830:134:3::10]:51961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f75uK-0004aL-Nr
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 17:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f75uJ-0002ND-FP
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 17:06:56 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-3-vsementsov@virtuozzo.com>
	<b3976794-7cb4-912d-d457-762dca65a2f8@redhat.com>
	<a5e15d04-9d0c-65f0-2368-4313f721dfc2@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f6e3d4d5-99e7-6833-5833-6a8c6b83c745@redhat.com>
Date: Fri, 13 Apr 2018 17:06:42 -0400
MIME-Version: 1.0
In-Reply-To: <a5e15d04-9d0c-65f0-2368-4313f721dfc2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] nbd/server: add
 nbd_meta_single_query helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com



On 04/13/2018 01:44 PM, Vladimir Sementsov-Ogievskiy wrote:
>=20
> will add, as always, thank you for natural rewording) Hm, I have a
> question: why do you often use double white-space "=C2=A0 " between
> sentences? Is it something meaningful?

There is some GREAT DEBATE in the English-speaking world over whether or
not this is correct typography. At one point, it was thought that there
should be two spaces after every full stop (".") to improve readability.
Allegedly, this was most important for physical typesetting on typewriter=
s.

Since digital typography has taken off, some people argue that this is a
relic and that semantically we ought to be using only one literal space
after the full stop, and using various kerning and display parameters to
extend the physical buffer between two sentences if desired.

Famously in my mind, PEP8 mandates the two spaces after a period style.

MLA says "One, unless your professor prefers two."
https://style.mla.org/number-of-spaces-after-period/

Chicago Manual of Style mandates one space after the full stop.
http://www.chicagomanualofstyle.org/qanda/data/faq/topics/OneSpaceorTwo.h=
tml

Strunk & White uses one space after the period:
https://www.legalwatercoolerblog.com/tag/strunk-and-white/

APA style (American Psychiatric Association) actually requests two
spaces after a period for *manuscripts*:
https://owl.english.purdue.edu/owl/resource/560/24/

I think it used to be the pedagogical norm to instruct students to type
two spaces after a period. Most institutions (Python documentation
excluded) do not recommend the practice currently.



*cough*



So it's not just the programming world that argues about things like
"tabs vs spaces." Literary nerds do it too.

I'm sure this email will be entirely without controversy. :)


Happy Friday,
--js
