Received: from eggs.gnu.org ([2001:4830:134:3::10]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jazeltq@gmail.com>) id 1chFLn-0001qk-LS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jazeltq@gmail.com>) id 1chFLm-0003Vc-RK
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:51:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170224114222.GA16659@localhost.localdomain>
References: <20170221065003.26103-1-jazeltq@gmail.com>
	<20170224035236.GB2613@localhost.localdomain>
	<CAKZcxgcWpz5g-WdeFNu8Ad_4PQZMPHoJDmn_1HENntVLLZG_Jg@mail.gmail.com>
	<20170224114222.GA16659@localhost.localdomain>
From: Jaze Lee <jazeltq@gmail.com>
Date: Fri, 24 Feb 2017 20:51:51 +0800
Message-ID: <CAKZcxgdkSA9JU55Wat1mvMn3XPVK9NyRuCCM8jFTSWdpkzVWSg@mail.gmail.com>
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

Sorry, I do not know. I thought we should always add RFC all though
the patch's life...
What is the prefix i should add? PATH 0 ?

2017-02-24 19:42 GMT+08:00 Jeff Cody <jcody@redhat.com>:
> On Fri, Feb 24, 2017 at 02:09:31PM +0800, Jaze Lee wrote:
>> 2017-02-24 11:52 GMT+08:00 Jeff Cody <jcody@redhat.com>:
>> > On Tue, Feb 21, 2017 at 02:50:03PM +0800, jazeltq@gmail.com wrote:
>> >> From: tianqing <tianqing@unitedstack.com>
>> >>
>> >> Rbd can do readv and writev directly, so wo do not need to transform
>> >> iov to buf or vice versa any more.
>> >>
>> >> Signed-off-by: tianqing <tianqing@unitedstack.com>
>> >> ---
>> >
>> >
>> > This is marked as an RFC still - is this a series you would like to se=
e in
>> > 2.9?
>>
>> Yes.   What should i do if i like it in 2.9
>>
>
> Ideally you would submit the series as a non-RFC patch (that is, it would
> have progressed to a normal patch away from RFC).
>
> But in this case, it seems to me that this patch has progressed beyond RF=
C;
> is there any reason it is still marked as RFC instead of just a patch?  I=
t
> looks OK to me.
>



--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
