Received: from eggs.gnu.org ([2001:4830:134:3::10]:35523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGTd3-0001co-Lj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGTd2-0006PE-Mn
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:11:21 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGTd2-0006P3-FA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:11:20 -0400
Received: by mail-wm0-x229.google.com with SMTP id b84so166740770wmh.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 10:11:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496250547-20701-1-git-send-email-armbru@redhat.com>
References: <1496250547-20701-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 18:10:58 +0100
Message-ID: <CAFEAcA-A_sr=j0aE2kORS7hwxZu8gT1+mkFkqFufKgaEex=tsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] QAPI patches for 2017-05-31
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

On 31 May 2017 at 18:09, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b04:
>
>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-30 14:15:15 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-31
>
> for you to fetch changes up to c0644771ebedbd8f47f3c24816445e30111d226b:
>
>   qapi: Reject alternates that can't work with keyval_parse() (2017-05-31 16:04:09 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-05-31
>
> ----------------------------------------------------------------
> Markus Armbruster (4):
>       qobject-input-visitor: Reject non-finite numbers with keyval
>       qapi: Document visit_type_any() issues with keyval input
>       tests/qapi-schema: Avoid 'str' in alternate test cases
>       qapi: Reject alternates that can't work with keyval_parse()
>

Applied, thanks.

-- PMM
