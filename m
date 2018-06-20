Received: from eggs.gnu.org ([2001:4830:134:3::10]:45689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVeCA-0000Vz-U4
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVeC7-0007ys-0H
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:34:50 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVeC6-0007yc-PF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:34:46 -0400
Received: by mail-wm0-x235.google.com with SMTP id 69-v6so122848wmf.3
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:34:46 -0700 (PDT)
References: <20180619154435.18898-1-alex.bennee@linaro.org>
	<CAFEAcA_QYqnSZo1yL+iYoWyvnGDvW7Lhp3pv2rPzeSfZXS3khg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_QYqnSZo1yL+iYoWyvnGDvW7Lhp3pv2rPzeSfZXS3khg@mail.gmail.com>
Date: Wed, 20 Jun 2018 15:34:44 +0100
Message-ID: <87r2l1v857.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/56] add check-tcg and associated machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 19 June 2018 at 16:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799=
fa2:
>>
>>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-201=
80615a' into staging (2018-06-15 18:13:35 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-190=
618-1
>>
>> for you to fetch changes up to 03c79cb5825f2e930a39839e8375dc0feef6d57d:
>>
>>   .travis.yml: add check-tcg test (2018-06-19 16:38:54 +0100)
>>
>> ----------------------------------------------------------------
>> Add check-tcg machinary
>>
>> This restores the ability to run TCG smoke tests by using our docker
>> infrastructure to support cross building simple tests. It represents
>> the first step to making better cross-architecture testing available
>> straight from the source tree ;-)
>>
>
> Also, I've just noticed that your commit messages are
> full of the 'below-the-fold' info about changes since
> v3, v4, etc. That shouldn't be in commits in pull requests,
> please.

Doh... let me add that to my pullreq script...

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
