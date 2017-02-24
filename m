Received: from eggs.gnu.org ([2001:4830:134:3::10]:39612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jazeltq@gmail.com>) id 1ch94S-0006jU-Iu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jazeltq@gmail.com>) id 1ch94R-0003bY-Md
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:09:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170224035236.GB2613@localhost.localdomain>
References: <20170221065003.26103-1-jazeltq@gmail.com>
	<20170224035236.GB2613@localhost.localdomain>
From: Jaze Lee <jazeltq@gmail.com>
Date: Fri, 24 Feb 2017 14:09:31 +0800
Message-ID: <CAKZcxgcWpz5g-WdeFNu8Ad_4PQZMPHoJDmn_1HENntVLLZG_Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v6] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, ceph-devel <ceph-devel@vger.kernel.org>, tianqing <tianqing@unitedstack.com>

2017-02-24 11:52 GMT+08:00 Jeff Cody <jcody@redhat.com>:
> On Tue, Feb 21, 2017 at 02:50:03PM +0800, jazeltq@gmail.com wrote:
>> From: tianqing <tianqing@unitedstack.com>
>>
>> Rbd can do readv and writev directly, so wo do not need to transform
>> iov to buf or vice versa any more.
>>
>> Signed-off-by: tianqing <tianqing@unitedstack.com>
>> ---
>
>
> This is marked as an RFC still - is this a series you would like to see i=
n
> 2.9?

Yes.   What should i do if i like it in 2.9

--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
