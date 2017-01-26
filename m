Received: from eggs.gnu.org ([2001:4830:134:3::10]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWoE4-0000PO-IN
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWoE1-0008TO-EE
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:52:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWoE1-0008TK-8T
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:52:45 -0500
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d95139a6-0e38-75b5-b8df-b4e12391e032@redhat.com>
Date: Thu, 26 Jan 2017 18:52:42 +0100
MIME-Version: 1.0
In-Reply-To: <265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu-devel] Poll on QEMU documentation project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>



On 26/01/2017 18:40, G 3 wrote:
>=20
> On Jan 26, 2017, at 12:30 PM, Paolo Bonzini wrote:
>=20
>>
>>
>> On 26/01/2017 18:28, G 3 wrote:
>>>
>>> On Jan 26, 2017, at 12:00 PM, qemu-devel-request@nongnu.org wrote:
>>>
>>>>
>>>> Hi all,
>>>>
>>>> as you may know I've been collecting some ideas about documentation =
for
>>>> QEMU at http://wiki.qemu-project.org/Features/Documentation.
>>>>
>>>> I've now prepared a poll to understand how familiars developers are
>>>> with
>>>> various documentation tools.  I've CCed people with most commits to
>>>> QEMU
>>>> documentation, or with whom I have discussed about this before, but
>>>> everybody's opinion is of course welcome!
>>>>
>>>> The poll is hosted with Google Forms and you can fill it in at
>>>> https://goo.gl/Yfxj1M.  If you hate Google Forms, contact me offlist
>>>> and
>>>> I'll send you the questions by email (and remind you when I need
>>>> someone
>>>> to review my patches).
>>>>
>>>> Paolo
>>>>
>>>>
>>>> tl;dr: poll is at https://goo.gl/Yfxj1M
>>>
>>>
>>> For this question:
>>> What's your opinion on the maintainability of the following
>>> documentation formats?
>>>
>>> Is it from 1(least maintainable) to 5 (most maintainable)?
>>>
>>> The survey looks good. I will take it.
>>
>> Yes, all of them are 1=3Dbad 5=3Dgood.
>=20
> Could we add HTML to the list of documentation formats?

Since you have mentioned that in the comments and someone else mentioned
AsciiDoc, they weren't included because:

- HTML is mostly a destination format.  With the listed formats it is
possible to produce a variety of outputs (mostly HTML itself and PDF;
secondarily text or ePub or others).

- AsciiDoc was considered by the Linux kernel folks but they complained
about the tools.

Paolo
