Received: from eggs.gnu.org ([2001:4830:134:3::10]:58821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chengang@emindsoft.com.cn>) id 1evmcj-0000ze-Tx
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chengang@emindsoft.com.cn>) id 1evmcf-0004Hx-Um
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:01 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:59332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
	id 1evmcf-0004Ex-CD
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:17:57 -0400
Message-ID: <5AA7FE59.9020206@emindsoft.com.cn>
Date: Wed, 14 Mar 2018 00:37:45 +0800
From: Chen Gang <chengang@emindsoft.com.cn>
MIME-Version: 1.0
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
In-Reply-To: <c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>, Chris Metcalf <cmetcalf@ezchip.com>, "walt@tilera.com" <walt@tilera.com>


On 2/28/18 20:41, Bastian Koppelmann wrote:
> On 02/28/2018 07:11 AM, Thomas Huth wrote:
>> On 27.02.2018 12:51, Peter Maydell wrote:
>>
>>> Possibly there are other target architectures we could reasonably
>>> deprecate-and-remove (though none of the other ones Linux is dropping
>>> in this round are ones we support)...
>>
>> I'd vote for marking tilegx as deprecated, too, since we even do not
>> have an active maintainer for that CPU core (at least I did not spot o=
ne
>> in our MAINTAINERS file). Opinions?
>=20
> I always saw it as a big plus that QEMU supports nearly any
> architecture, no matter how obscure it is. So I'm a bit more hesitant o=
n
> dropping architectures quickly.
>=20

Firstly, sorry for too long time to no response about tilegx.

During latest 2 years, I turned to android development (custom aosp with
java/c++/c, merge android and linux together), and revert engineering
about android (java/c).

At present, sorry, I really have no time for tilegx any more. :(

For me, tilegx is still a good platform, and we have done much things,
now, so if we can find another maintainers/volunteers for it, I hope
qemu can still support tilegx.

By the way, for floating point instructions patches, I have sent before
(2 years ago), it seems I did not get any reply. I hope they are useful
for tilegx.

Thanks.
--=20
Chen Gang (=E9=99=88=E5=88=9A)
