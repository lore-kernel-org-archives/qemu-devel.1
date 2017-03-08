Received: from eggs.gnu.org ([2001:4830:134:3::10]:48780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clYCB-0004Ol-R9
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clYCA-0002LS-Tl
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:47:47 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clYCA-0002LF-NM
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:47:46 -0500
Received: by mail-wr0-x234.google.com with SMTP id u108so19303958wrb.3
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 01:47:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488900045-26344-1-git-send-email-armbru@redhat.com>
References: <1488900045-26344-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Mar 2017 10:47:24 +0100
Message-ID: <CAFEAcA_XDTHWPZRn4c1FnSeKi2Dx05y--J6kXP3g+640V96YQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v4 00/24] block: Command line option
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

On 7 March 2017 at 16:20, Markus Armbruster <armbru@redhat.com> wrote:
> Actually, the command line option is the least part of this series.
> Its bulk is about building infrastructure and getting errors out of
> the JSON parser.
>
> The design of the command line interface was discussed here:
> Subject: Non-flat command line option argument syntax
> Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>
> v4: PATCH 03: One-liner to placate clang sanitizer
> v3: A few commit messages touched up, code unchanged
>
> The following changes since commit ff79d5e939c38677a575e3493eb9b4d36eb21865:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20170306-xtensa' into staging (2017-03-07 09:57:14 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28-v4
>
> for you to fetch changes up to 0b2c1beea4358e40d1049b8ee019408ce96b37ce:
>
>   keyval: Support lists (2017-03-07 16:07:48 +0100)
>


Applied, thanks.

-- PMM
