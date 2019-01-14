Received: from eggs.gnu.org ([209.51.188.92]:35685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1giwAs-00032N-VM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1giwAp-0002Se-T4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:56:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1giwAp-0002S8-NX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:56:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190107111129.2087-1-alex.bennee@linaro.org>
	<CAL1e-=jZACpchHLoF_CtaLtLiySr0t527eao2wGci7Rsz1h2zg@mail.gmail.com>
	<87muo7ulau.fsf@linaro.org>
Date: Mon, 14 Jan 2019 07:56:37 +0100
In-Reply-To: <87muo7ulau.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Fri, 11 Jan 2019 18:00:09 +0000")
Message-ID: <871s5fybfe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/3] gitdm updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, "cota@braap.org" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>
>> On Monday, January 7, 2019, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>>>
>>> Hi,
>>>
>>> Added a few more updates mostly of IBMers with non corporate emails.
>>
>>
>> Alex, it seems logical to me that you also create a section on gitdm in
>> MAINTAINERS, and set yourself as the maintainer for contrib/gitdm/*.
>
> I guess - do we do that for other contrib stuff?

Same answer as for all the other stuff: sometimes ;-P

Back to serious.  Since you're quite obviously maintaining it now, why
not make it official?
