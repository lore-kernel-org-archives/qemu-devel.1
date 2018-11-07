Received: from eggs.gnu.org ([2001:4830:134:3::10]:47730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKQNd-0002w5-PS
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKQNV-00065t-TL
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:08:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1541528230-31817-1-git-send-email-thuth@redhat.com>
	<c0febf9a-f098-112d-9c8d-c320cc66b04a@redhat.com>
	<12974ebb-09de-c6e9-1dd7-5199a8ae6b05@redhat.com>
	<CAFEAcA-B74FQgj3COyGZ_SAAvSUA6=OaLdy5--NoAgHgEGZkpg@mail.gmail.com>
Date: Wed, 07 Nov 2018 17:08:05 +0100
In-Reply-To: <CAFEAcA-B74FQgj3COyGZ_SAAvSUA6=OaLdy5--NoAgHgEGZkpg@mail.gmail.com>
	(Peter Maydell's message of "Tue, 6 Nov 2018 18:58:44 +0000")
Message-ID: <87k1louaze.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for the 'collie'
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 6 November 2018 at 18:52, Thomas Huth <thuth@redhat.com> wrote:
>> On 2018-11-06 19:49, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 6/11/18 19:17, Thomas Huth wrote:
>>>> There is no active maintainer, but since Peter is picking up
>>>> patches via qemu-arm@nongnu.org, I think we could at least use
>>>> "Odd Fixes" as status here.
>>>
>>> This looks more as "Orphan" to me...
>>
>> I'll leave it up to Peter for the final decision...
>
> I think we're not very consistent[*] in our usage of the various
> statuses in the MAINTAINERS file. I guess "Odd Fixes" makes
> sense in that, well, if you send a patch to this
> code and cc me I'll review it and put it in the tree. (This
> is true of any of the arm boards we have.)
>
> [*] We have one thing tagged Orphan, which is bsd-user/,
> and some things tagged Odd Fixes with no listed maintainer,
> and some things tagged Odd Fixes which are in practice more
> like Orphan (for instance sh4), and we list "fpu/" as
> Odd Fixes despite having given it a pretty thorough
> overhaul very recently, and so on...
>
> If you wanted a mechanizable rule, you could try something
> like "every file which is in status Odd Fixes or better
> must list with M: at least one named individual who has
> submitted a pull request in the last nine months" :-)

Sounds like an excellent idea to me!
