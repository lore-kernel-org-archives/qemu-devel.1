Received: from eggs.gnu.org ([2001:4830:134:3::10]:37674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuFNb-0001Z3-KX
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuF7v-0005ZA-82
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:52:12 -0400
References: <20180824133757.1cbdba75.cohuck@redhat.com>
	<a29f4cdd-8012-d46e-8984-b4e223f1957f@redhat.com>
	<20180827124058.36aa13ee.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e6463614-cf70-6f2e-5d90-5ace62ce8aee@redhat.com>
Date: Mon, 27 Aug 2018 12:52:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180827124058.36aa13ee.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFD] [s390x] Tweaking the s390x maintainership
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 2018-08-27 12:40, Cornelia Huck wrote:
> On Mon, 27 Aug 2018 11:26:21 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 24.08.2018 13:37, Cornelia Huck wrote:
[...]
>>> * I'd also like to have a designated backup for the overall
>>>   maintainership, especially for when I'm on vacation (like the first
>>>   two weeks of September, just to let you know :) or otherwise
>>>   unavailable, but also for sanity. Likely needs to be a non-IBMer du=
e
>>>   to the tcg problem. =20
>>
>> Either Thomas or I could do that. I will be on vacation the first two
>> weeks of September, too ;) Thomas, interested?
>=20
> Maybe both of you? I doubt we'll be on vacation during the same time
> period every time ;)

Hmm, we already have Christian for the non-TCG stuff, and Richard is
listed in MAINTAINERs in the S390 TCG section. So I think we should
already be fine to cover you during your holidays for all areas,
shouldn't we?

Anyway, sure, I can also keep my eyes on the incoming patches during the
two weeks.

 Thomas
