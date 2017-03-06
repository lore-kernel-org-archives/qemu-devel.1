Received: from eggs.gnu.org ([2001:4830:134:3::10]:59188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckuEF-0004Qp-SF
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckuEA-0005fM-3l
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:07:15 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckuE9-0005ez-To
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:07:10 -0500
Received: by mail-wr0-x22d.google.com with SMTP id l37so118779925wrc.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 07:07:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488809515-4047-1-git-send-email-armbru@redhat.com>
References: <1488809515-4047-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 15:06:48 +0000
Message-ID: <CAFEAcA_UAAbfGJz4rQ52e7TX3LR5qY1P8Xk4+zGYp2tMHBUTQg@mail.gmail.com>
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

On 6 March 2017 at 14:11, Markus Armbruster <armbru@redhat.com> wrote:
> Actually, the command line option is the least part of this series.
> Its bulk is about building infrastructure and getting errors out of
> the JSON parser.
>
> The design of the command line interface was discussed here:
> Subject: Non-flat command line option argument syntax
> Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>
> The following changes since commit aa3a982e674b09ae32502940f93ba98b3a8ad50e:
>
>   qapi: Improve qobject visitor documentation (2017-03-05 09:14:20 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28-v2
>
> for you to fetch changes up to 3a79d43588cff95636d5ccdfa77b372cfd6d8530:
>
>   keyval: Support lists (2017-03-05 10:29:58 +0100)
>
> ----------------------------------------------------------------
> block: Command line option -blockdev

This appears to be a pull request for a feature change
after freeze ?

thanks
-- PMM
