Received: from eggs.gnu.org ([2001:4830:134:3::10]:43101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cakE5-0001rQ-BD
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cakE4-0005NR-Cl
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:25:05 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nirsof@gmail.com>) id 1cakE4-0005N7-8h
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:25:04 -0500
Received: by mail-ot0-x242.google.com with SMTP id f9so10511264otd.0
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 06:25:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170206102019.GC5377@lemon.lan>
References: <20170128035929.10168-2-nirsof@gmail.com>
	<20170206102019.GC5377@lemon.lan>
From: Nir Soffer <nirsof@gmail.com>
Date: Mon, 6 Feb 2017 16:25:02 +0200
Message-ID: <CAMr-obtbdiSJb0zqOsdptJSv2PgcOANMEB_BYj2rg42mPjH8Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qemu-io: Add regression tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>

This was created by mistake with --no-thread and no cover letter, I
was confused by the instructions in the wiki, warning not to send
multiple patches in the same thread.

I already sent v4 and v5 properly.

Thanks for the comments,
Nir

On Mon, Feb 6, 2017 at 12:20 PM, Fam Zheng <famz@redhat.com> wrote:
> On Sat, 01/28 05:59, Nir Soffer wrote:
>> From: Nir Soffer <nsoffer@redhat.com>
>>
>> Add regression tests checking that qemu-io fail with non-zero exit code
>> when reading non-existing file or using the wrong format.
>>
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>
> This message is not correctly threaded as a reply to a v3 cover letter, and it's
> hard to review. Please check your git command lines comform to the instructions
> in
>
> http://wiki.qemu-project.org/Contribute/SubmitAPatch#Submitting_your_Patches
>
> Particularly, --cover-letter and --thread should be used in git-format-email.
>
> Fam
