Received: from eggs.gnu.org ([2001:4830:134:3::10]:51779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNKaS-0000Zf-Sz
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNKaO-0006Vn-PU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:57:00 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNKaO-0006VR-J1
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:56:56 -0400
Received: by mail-wr0-x22e.google.com with SMTP id y25so55176217wrd.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:56:56 -0700 (PDT)
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-13-alex.bennee@linaro.org>
	<CAFEAcA_oRmWiQKyj=xSHyR1n-zDWfGJ4n3d4DzzWQtn3rTr1yA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_oRmWiQKyj=xSHyR1n-zDWfGJ4n3d4DzzWQtn3rTr1yA@mail.gmail.com>
Date: Tue, 20 Jun 2017 15:57:37 +0100
Message-ID: <87vanqu2ou.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v5 12/13] new: record_traces.sh helper
 script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 19 June 2017 at 11:46, Alex Bennée <alex.bennee@linaro.org> wrote:
>> A simple script to run through a bunch of binaries and generate their
>> trace files.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v5
>>   - author, license and usage header
>> v3
>>   - allow overriding of RISU binary
>> ---
>>  record_traces.sh | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100755 record_traces.sh
>
> Another one for contrib/, I think.

OK will do.

>
> thanks
> -- PMM


--
Alex Bennée
