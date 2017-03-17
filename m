Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1coru7-0004AG-NA
	for Qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1coru3-0004mG-Oz
	for Qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:26:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1coru3-0004kU-Ip
	for Qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:26:47 -0400
Date: Fri, 17 Mar 2017 09:26:42 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170317132642.GC3411@localhost.localdomain>
References: <CAF++6APFk2KY-7yFYtsgcTwn31RCf_Wxucp3eTLbB2e1c5QAyg@mail.gmail.com>
	<CAFEAcA9NPoujRE47pyNEui-DwxwisNpmGNp0w4B_+_mwbuV_4Q@mail.gmail.com>
	<CAF++6AN8-pKhPKNQPDnCkXzQdqo4hPTH6eJetuzQXmsBkDXRNA@mail.gmail.com>
	<CAF++6AMLAdzz0npAQYwenDOZJNqLgp+5oLNSR_R-XqFxhenKaw@mail.gmail.com>
	<CAFEAcA8gnWzkVupKJYG3kFZXi7Q-9d8J335b+sbbbL49YH3A_Q@mail.gmail.com>
	<20170315170205.GA3411@localhost.localdomain>
	<CAF++6AO+C59nZ_-fUCkpEoYanD1CerakkpiZFsPjhnTyYJ03jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAF++6AO+C59nZ_-fUCkpEoYanD1CerakkpiZFsPjhnTyYJ03jg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] submodule-update queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hanley <jhanley@dgtlrift.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <Qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Mar 17, 2017 at 09:06:20AM -0400, James Hanley wrote:
>    Thanks - that seemed to resolve the issue.=A0 Will the synchronizati=
on
>    scripts be updated for all repositories? I was also seeing the same =
issue
>    when references for submodules roms/SLOF and roms/seabios were updat=
ed.
>    -Jim

Hi,

Thanks for the verification.  Yes, the scripts have been updated for all
repositories.

Thanks,
Jeff
