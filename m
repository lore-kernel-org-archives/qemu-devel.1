Received: from eggs.gnu.org ([2001:4830:134:3::10]:59344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckuFK-0004yd-5c
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckuFI-0005qm-Ny
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:08:22 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckuFI-0005qh-Hq
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:08:20 -0500
Received: by mail-wm0-x232.google.com with SMTP id t193so67021261wmt.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 07:08:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_UAAbfGJz4rQ52e7TX3LR5qY1P8Xk4+zGYp2tMHBUTQg@mail.gmail.com>
References: <1488809515-4047-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_UAAbfGJz4rQ52e7TX3LR5qY1P8Xk4+zGYp2tMHBUTQg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 15:07:59 +0000
Message-ID: <CAFEAcA8CgUEOZuj1+jhRHqJnDUzFxrGWo=j9EAe4u75S6rnV0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/24] block: Command line option
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2017 at 15:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 6 March 2017 at 14:11, Markus Armbruster <armbru@redhat.com> wrote:
>> Actually, the command line option is the least part of this series.
>> Its bulk is about building infrastructure and getting errors out of
>> the JSON parser.
>>
>> The design of the command line interface was discussed here:
>> Subject: Non-flat command line option argument syntax
>> Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>>
>> The following changes since commit aa3a982e674b09ae32502940f93ba98b3a8ad50e:
>>
>>   qapi: Improve qobject visitor documentation (2017-03-05 09:14:20 +0100)
>>
>> are available in the git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28-v2
>>
>> for you to fetch changes up to 3a79d43588cff95636d5ccdfa77b372cfd6d8530:
>>
>>   keyval: Support lists (2017-03-05 10:29:58 +0100)
>>
>> ----------------------------------------------------------------
>> block: Command line option -blockdev
>
> This appears to be a pull request for a feature change
> after freeze ?

...oh, v2 of something that failed first time round. Sorry,
I'm not really awake this afternoon.

thanks
-- PMM
