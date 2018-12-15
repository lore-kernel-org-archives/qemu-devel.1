Received: from eggs.gnu.org ([2001:4830:134:3::10]:45362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYIOd-0001aP-HB
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 17:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYIOc-0000Wp-Fs
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 17:26:55 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:42737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYIOc-0000UW-7f
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 17:26:54 -0500
Received: by mail-oi1-x22c.google.com with SMTP id w13so7393140oiw.9
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 14:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20181214060526.30042-1-armbru@redhat.com>
In-Reply-To: <20181214060526.30042-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 15 Dec 2018 22:26:41 +0000
Message-ID: <CAFEAcA_OV6a++hcRnpdhKbrQeS9HR6NwU68mOtteZPLWCcOF1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/32] QAPI patches for 2018-12-13
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

On Fri, 14 Dec 2018 at 06:06, Markus Armbruster <armbru@redhat.com> wrote:
>
> git-request-pull master public pull-qapi-2018-12-13-v2
> The following changes since commit c3ec0fa1a8e815ecfec9eabb9c20ee206c313e07:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2018-12-12' into staging (2018-12-13 13:41:44 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-12-13-v2
>
> for you to fetch changes up to 335d10cd8e2c3bb6067804b095aaf6371fc1983e:
>
>   qapi: add conditions to REPLICATION type/commands on the schema (2018-12-14 06:52:48 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2018-12-13
>
> * Rewrite the ugly parts of string-input-visitor
> * Support conditional QAPI enum, struct, union and alternate members
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
