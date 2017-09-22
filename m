Received: from eggs.gnu.org ([2001:4830:134:3::10]:37124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dvUSe-0005Hb-SW
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dvUSa-00039n-UK
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:22:08 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:34716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dvUSa-00039V-PD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:22:04 -0400
Received: by mail-io0-x243.google.com with SMTP id g32so258959ioj.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 13:22:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170922124405.GB32000@lemon>
Date: Fri, 22 Sep 2017 16:22:02 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <D76563D8-D9EB-47E2-9479-DC1A6C34DA3E@gmail.com>
References: <mailman.3351.1506066493.14747.qemu-devel@nongnu.org>
	<726A2123-0371-407B-9270-6672DF66D511@gmail.com>
	<20170922124405.GB32000@lemon>
Subject: Re: [Qemu-devel] [PULL 28/36] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Sep 22, 2017, at 8:44 AM, Fam Zheng <famz@redhat.com> wrote:
>=20
> On Fri, 09/22 08:10, Programmingkid wrote:
>> Could a Darwin test be added? Both x86 and PowerPC versions would be =
great.
>=20
> It's nice to cover macOS in our test, but to be honest I don't know =
how to do
> it. If there isn't any copyright problem, and if there are =
instructions
> available in wiki.qemu.org descirbing how to create such a guest step =
by step
> like [1], we can add one.
>=20
> [1]: https://wiki.qemu.org/Hosts/BSD
>=20
> Fam

Mac OS X is built on top of Darwin. Darwin is completely open source and =
free. There are no copyright issues because it is released under the =
Apple Public Source License.=20

I think I can make the directions available in the wiki soon.=20=
