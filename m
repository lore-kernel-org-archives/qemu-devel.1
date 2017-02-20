Received: from eggs.gnu.org ([2001:4830:134:3::10]:48707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cfqUD-0000La-Lf
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cfqU8-0005ZC-Pd
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:06:49 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cfqU8-0005Z0-JK
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:06:44 -0500
Received: by mail-wr0-x229.google.com with SMTP id z61so66766536wrc.1
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 08:06:44 -0800 (PST)
References: <20170220105139.21581-1-alex.bennee@linaro.org>
	<20170220141424.GA358@lemon.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170220141424.GA358@lemon.lan>
Date: Mon, 20 Feb 2017 16:06:48 +0000
Message-ID: <87h93ox2w7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 0/4] Docker cross-compile targets and
 user build support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Mon, 02/20 10:51, Alex Bennée wrote:
>> Hi Fam,
>>
>> Hopefully this is the final iteration. A couple of minor typos fixes
>> and your suggestions taken into account. I have also added some
>> review/tesing tags from Philippe.
>
> Looks good to me, Thanks! Let me know if you want to merge it yourself,
> otherwise I'll send a pull request later this week.

No you go ahead and send the pull request when your ready ;-)

--
Alex Bennée
