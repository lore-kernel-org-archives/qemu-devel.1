Received: from eggs.gnu.org ([2001:4830:134:3::10]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cORbQ-0001hd-AH
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cORbM-0000eC-Va
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:06:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cORbM-0000e5-PW
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:06:16 -0500
References: <a6803686-9435-0276-0118-10961dc97e04@redhat.com>
	<20170103155347.GF14707@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68e906ee-5604-644c-78cd-d39f0d164406@redhat.com>
Date: Tue, 3 Jan 2017 17:06:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170103155347.GF14707@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Proposal for 2.9 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>



On 03/01/2017 16:53, Stefan Hajnoczi wrote:
> On Fri, Dec 23, 2016 at 03:15:58PM +0100, Paolo Bonzini wrote:
>> Considering that Easter is on April 16th, we'd probably want to have t=
he
>> release before that date even in case of a slip.
>>
>> On the other hand, the Christmas / New Year break here means that we'l=
l
>> have to make the development time 1-2 week shorter in practice.
>>
>> 2016-02-21     2.9 soft freeze
>> 2016-03-07     hard freeze / rc0
>> 2016-03-28     rc3 (+3 weeks)
>> 2016-04-04     rc4 or release
>> 2016-04-11     release (if rc4)
>>
>> One possibility is to make soft freeze happen a few days later.
>> Peter/Stefan, how did the experiment go with the new rules for soft
>> freeze?  Is it worth repeating it for 2.9 and would it make sense to
>> shorten soft freeze given the new rules?
>=20
> I would shorten the soft freeze by 1 week.
>=20
> Overall the 2.8 release went smoothly.  We got unlucky right at the end
> with a release blocker but otherwise it was fine.

Then what about soft freeze on 2016-02-28?

Thanks,

Paolo
