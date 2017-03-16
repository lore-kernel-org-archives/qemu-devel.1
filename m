Received: from eggs.gnu.org ([2001:4830:134:3::10]:56263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coWJ8-0004gc-9F
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coWJ7-0001FY-BD
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:23:14 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coWJ7-0001FH-4L
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:23:13 -0400
Received: by mail-wr0-x233.google.com with SMTP id l37so33229753wrc.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 07:23:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 14:22:51 +0000
Message-ID: <CAFEAcA-aArdebeGpNJDjm9DMcAe4AT7uYvSCSvgA9K=p+6d3qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for 2.9 00/49] QAPI patches for 2017-03-16
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

On 16 March 2017 at 06:27, Markus Armbruster <armbru@redhat.com> wrote:
> Significant improvements to QMP documentation, fixing its regression.
>
> Note: only QAPI *generator* code changes, except for trailing space
> removal in generated qmp-marshal.c and doc comments in QAPI schemas.
>
> The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-03-16
>
> for you to fetch changes up to 012b126de2ded4e93b5ed069be5544ad8a2e6c15:
>
>   qapi: Fix a misleading parser error message (2017-03-16 07:13:04 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-03-16
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
