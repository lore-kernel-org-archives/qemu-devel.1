Received: from eggs.gnu.org ([2001:4830:134:3::10]:49936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fDmPx-0001bW-MI
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fDmPw-0007CY-ID
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:43:13 -0400
Received: from mail-yw0-x22c.google.com ([2607:f8b0:4002:c05::22c]:40910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1fDmPw-0007C0-9n
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:43:12 -0400
Received: by mail-yw0-x22c.google.com with SMTP id p144-v6so4264060ywg.7
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 00:43:12 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20180502093326.2fbec55f.cohuck@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
MIME-Version: 1.0
Date: Wed, 2 May 2018 00:43:10 -0700
Message-ID: <CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 2 May 2018 at 10:38:09, Cornelia Huck (cohuck@redhat.com) wrote:

> > > >> a) Bump major version once a year, so we'll have 3.0, 3.1,
> 3.3,
> > >> 4.0, 4.1, 4.2, 5.0, ...etc We missed the first release this
> > >> year, so we would only have 3.0 and 3.1 this year.
> > >>
> > >> b) Bump major release when minor version gets double-digits.
> > >> eg 3.0, 3.1, ...., 3.9, 3.9, 4.0, ...., 4.9, 5.0...
> >
> > It's just a matter of taste, but I think I'd prefer variant b).
> That
> > will bump the major release approx. every three years which
> sounds like
> > a good time frame for me.
>
> I think anything that keeps release numbers in ascending order
> would
> basically work :)

not really.

I suggest you use semantic versioning:

https://semver.org


regards,

Liviu
