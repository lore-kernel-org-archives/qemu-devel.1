Received: from eggs.gnu.org ([2001:4830:134:3::10]:41616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHpeD-0004Nv-DS
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHpeA-0002ff-5L
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:26:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eHpe9-0002fA-Us
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:26:22 -0500
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<20171123111403.GH8166@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6bf8ebad-c741-4684-b00a-ca823d1a0d9c@redhat.com>
Date: Thu, 23 Nov 2017 12:26:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171123111403.GH8166@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 23.11.2017 12:14, Daniel P. Berrange wrote:
> On Thu, Nov 23, 2017 at 10:17:48AM +0000, Peter Maydell wrote:
>> On 23 November 2017 at 10:03, Cornelia Huck <cohuck@redhat.com> wrote:
>>> On Mon, 13 Nov 2017 08:14:28 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> By the way, before everybody now introduces "2.12" machine types ... is
>>>> there already a consensus that the next version will be "2.12" ?
>>>>
>>>> A couple of months ago, we discussed that we could maybe do a 3.0 after
>>>> 2.11, e.g. here:
>>>>
>>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
>>>>
>>>> I'd still like to see that happen... Peter, any thoughts on this?
>>>
>>> So, as I just thought about preparing the new machine for s390x as
>>> well: Did we reach any consensus about what the next qemu version will
>>> be called?
>>
>> I haven't seen any sufficiently solid plan to make me want to
>> pick anything except "2.12".
> 
> I would suggest we just make major version number changes explicitly an
> arbitrary choice. ie just bump the major version for the first release
> of each year. Or just always bump it when we get to x.5 o x.9.

FWIW, I like the idea to bump it when we get to x.9. (Having mixed up
x.1 and x.10 for other projects in the past already, I don't like two
digit minor release version numbers very much).

 Thomas
