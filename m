Received: from eggs.gnu.org ([2001:4830:134:3::10]:50458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej2Tv-0000Nr-3O
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej2Tr-000233-5V
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:36:15 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej2Tq-00022X-Ul
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:36:11 -0500
Received: by mail-wm0-x236.google.com with SMTP id v71so3543416wmv.2
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 04:36:10 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<87eflywebt.fsf@linaro.org>
	<11092ca9-6389-f417-6afb-c214a9995cde@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <11092ca9-6389-f417-6afb-c214a9995cde@amsat.org>
Date: Tue, 06 Feb 2018 12:36:08 +0000
Message-ID: <87d11iwb0n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 00/20] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 02/06/2018 08:24 AM, Alex Benn=C3=A9e wrote:
>>
>> I think this series is good to go.
>
> The x86 patch still require a volunteer to review ;)

It looks good enough for me although I'm only a casual observer of x86 ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
