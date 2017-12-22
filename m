Received: from eggs.gnu.org ([2001:4830:134:3::10]:54965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSJ5N-0002ao-5x
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSJ5L-000725-VD
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:53:45 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<87shc4umku.fsf@dusky.pond.sub.org>
	<d4c1aa6a-9583-ade6-4ef6-fc060fa5ffcd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8dceb718-b8eb-ce51-2af1-6b5efc2a0aa0@virtuozzo.com>
Date: Fri, 22 Dec 2017 11:53:32 +0300
MIME-Version: 1.0
In-Reply-To: <d4c1aa6a-9583-ade6-4ef6-fc060fa5ffcd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/6] nbd export qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, dgilbert@redhat.com

21.12.2017 21:32, Eric Blake wrote:
> On 12/21/2017 09:28 AM, Markus Armbruster wrote:
>> Looks like you forgot to cc: Eric. Fixing...
>
> Or that he did cc me, and the mailman bug ate the cc line because of=20
> my list subscription settings.=C2=A0 (Have I mentioned that I hate that=20
> mailman 2 bug, but don't know whether mailman 3 will make it any better?)
>

Hmm, when did it eat it? I've send this with git send-email, and in my=20
thunderbird I see (through view->source)

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>
CC: <armbru@redhat.com>, <dgilbert@redhat.com>, <pbonzini@redhat.com>,
	<eblake@redhat.com>, <mreitz@redhat.com>, <kwolf@redhat.com>,
	<vsementsov@virtuozzo.com>, <den@openvz.org>
Subject: [PATCH v2 0/6] nbd export qmp interface
Date: Thu, 7 Dec 2017 18:50:56 +0300
Message-ID: <20171207155102.66622-1-vsementsov@virtuozzo.com>



--=20
Best regards,
Vladimir
