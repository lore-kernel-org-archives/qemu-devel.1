Received: from eggs.gnu.org ([2001:4830:134:3::10]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYX2s-0001YK-3b
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYX2r-0002ze-6u
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:28:38 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:37028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYX2q-0002zN-W3
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:28:37 -0400
Received: by mail-wr0-x235.google.com with SMTP id 33so25320503wrz.4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 05:28:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87379r86o6.fsf@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
	<87379r86o6.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 13:28:15 +0100
Message-ID: <CAFEAcA_Y8hMteukH-L6J_RHR05oxVBBf9TB+ZPYyPNY-uPHjmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/32] Final updates for Travis/Shippable
 for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 July 2017 at 16:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> Hmm it looked like the cover letter never made it to the list.
>
>> The following changes since commit 5a477a78060638b8433e9fb96a3ada100b1ab=
8e9:
>>
>>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reque=
st' into staging (2017-07-17 18:39:32 +0100)
>>
>> are available in the git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-ci-updates-for-softfreez=
e-180717-2
>>
>> for you to fetch changes up to 118d1becc0e6332145bb9d6aee8ed232eed770e8:
>>
>>   docker: install clang since Shippable setup_ve() verify it is availabl=
e (2017-07-18 10:58:36 +0100)
>>
>> ----------------------------------------------------------------
>> Final CI updates for soft-freeze
>>
>> Tweaks from Paolo for J=3Dx Travis compiles
>> Bunch of updated cross-compile targets from Philippe
>> Additional debug tools in travis image from Me
>>
>> ----------------------------------------------------------------

Applied, thanks.

-- PMM
