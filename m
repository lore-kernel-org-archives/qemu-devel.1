Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqMXd-0003UW-OV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqMXd-0003mZ-2E
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:58:37 -0400
References: <153443194444.18476.14489058164586135585@502c9da6d61e>
	<b998a9a1-218a-77fa-a217-617213d99848@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <515f3a0b-ff43-ca7d-155c-33ee329a74e3@redhat.com>
Date: Thu, 16 Aug 2018 12:58:25 -0500
MIME-Version: 1.0
In-Reply-To: <b998a9a1-218a-77fa-a217-617213d99848@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2] new, node-graph-based fleecing and backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

On 08/16/2018 12:28 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hmm, how should I properly set based-on, if there two series under this=
=20
> one?
>=20
> Based on:
>  =C2=A0=C2=A0 [PATCH v3 0/8] dirty-bitmap: rewrite bdrv_dirty_iter_next=
_area
>  =C2=A0=C2=A0 and
>  =C2=A0=C2=A0 [PATCH 0/2] block: make .bdrv_close optional

patchew goes off mail ids, so I'll rewrite the above in a=20
machine-readable format:

Based-on: <20180814121443.33114-1-vsementsov@virtuozzo.com>
Based-on: <20180814124320.39481-1-vsementsov@virtuozzo.com>


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
