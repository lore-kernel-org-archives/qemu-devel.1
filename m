Received: from eggs.gnu.org ([2001:4830:134:3::10]:51268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPQAD-0004Ii-LD
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPQA8-0004NC-2f
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:18:33 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:54130)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPQA7-0004He-Mm
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:18:27 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
	<1496975122-16999-8-git-send-email-cota@braap.org>
	<20170626082844.GA4181@redhat.com>
Date: Mon, 26 Jun 2017 12:18:14 +0300
In-Reply-To: <20170626082844.GA4181@redhat.com> (Daniel P. Berrange's message
	of "Mon, 26 Jun 2017 09:28:44 +0100")
Message-ID: <87d19rf6p5.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 7/7] trace: [trivial] Statically enable
 all guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

Daniel P Berrange writes:

> On Thu, Jun 08, 2017 at 10:25:22PM -0400, Emilio G. Cota wrote:
>> From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>=20
>> The optimizations of this series makes it feasible to have them
>> available on all builds.

> I'm not saying you're wrong, but where is the data to backup this
> assertion ?

> IMHO, this commit message should be describing how performance was
> tested and what the results were.

I can submit a new series with the performance measurements now that you've
informally OK'ed Emilio's new patch.

Is there some public script to automate that or do I have to cook my own?


Thanks,
  Lluis
