Received: from eggs.gnu.org ([2001:4830:134:3::10]:60126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eni3X-0003Wf-Uo
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eni3U-000702-2J
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:48:19 -0500
References: <1518824446-20235-1-git-send-email-cota@braap.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1942dfce-85aa-1c62-aa80-8608c789088f@redhat.com>
Date: Mon, 19 Feb 2018 10:48:05 +0100
MIME-Version: 1.0
In-Reply-To: <1518824446-20235-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] target/s390x: translation loop
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org

On 17.02.2018 00:40, Emilio G. Cota wrote:
> Tested with the "Moon Buggy" image:
>   http://www.qemu-advent-calendar.org/2014/#day-22
>=20
> Thanks,
>=20
> 		Emilio
>=20

This also passes kvm-unit-tests and and fedora27 boots fine.

--=20

Thanks,

David / dhildenb
