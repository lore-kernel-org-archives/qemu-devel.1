Received: from eggs.gnu.org ([2001:4830:134:3::10]:57982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUHPQ-0002Rt-FJ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUHPP-0006sV-Hy
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:26:04 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUHPP-0006sJ-Eh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:26:03 -0500
Received: by mail-ua0-x22f.google.com with SMTP id i68so42553817uad.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 10:26:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170119180223.55d75d6d@squid.athome>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
	<CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
	<20170111123552.1873cb3b@squid.athome>
	<20170112142836.53bbd87b@squid.athome>
	<CAFEAcA8eYeLNrTK-hupM9jA7CPjD8OgEU85As94fWXQETxRgXA@mail.gmail.com>
	<20170118165256.GC6657@thinpad.lan.raisama.net>
	<CAFEAcA-VmK+oMdV7GONa=H2v6Oz1uO=gaM3UgRf0SvK1QHO+3w@mail.gmail.com>
	<20170119180223.55d75d6d@squid.athome>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 18:25:42 +0000
Message-ID: <CAFEAcA8d2VU8goDtC7G5sek1_-PmmEZ02Devhb1ihoSSfhBuAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/6] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 19 January 2017 at 18:02, Julian Brown <julian@codesourcery.com> wrote:
> We're using integratorcp

That board model is extremely ancient and unloved, by the way.
If we ever make good on the suggestion from last year to start
deprecating and eventually removing unmaintained board models,
it's probably going to be on the list of victims...

thanks
-- PMM
